/* global Vue, VueRouter, axios, google, usAirports */

var useCachedTrips = true;
// tried to generate random picture for cards
// var tripBackground = ["img/tripBackgrounds/beach1.jpg", "img/tripBackgrounds/beach2.jpg", "img/tripBackgrounds/chicago.jpg", "img/tripBackgrounds/city1.jpg", "img/tripBackgrounds/denver.jpg", "img/tripBackgrounds/lake.jpg", "img/tripBackgrounds/lasvegas.jpg", "img/tripBackgrounds/miami.jpg", "img/tripBackgrounds/myrtlebeach.jpg", "img/tripBackgrounds/palmtrees.jpg", "img/tripBackgrounds/savannah.jpg", "img/tripBackgrounds/seattle.jpg", "img/tripBackgrounds/ski.jpg", "img/tripBackgrounds/winetour.jpg", "img/tripBackgrounds/virginia.jpg"];

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      trips: [],
      currentTrip: {
        user_id: "",
        destination: "",
        home_airport: "",
        destination_airport: "",
        start_date: "",
        end_date: "",
        budget_flight: "",
        budget_accom: "",
        budget_food: "",
        budget_fun: "",
      },
    };
  },
  created: function() {
    axios.get("/v1/trips").then(
      function(response) {
        this.trips = response.data;
        console.log('trips', this.trips);
        localStorage.setItem("cachedTrips", JSON.stringify(response.data));
      }.bind(this)
    );
  },
  methods: {
    setCurrentTrip: function(inputTrip) {
      this.currentTrip = inputTrip;
    },
    // tried to generate random picture for cards
    // choosePic: function() {
    //   var randomNum = Math.floor(Math.random() * tripBackground.length);
      
    // },
  },
  computed: {},
};

var TripsNewPage = {
  template: "#trips-new-page",
  mounted() {
    this.autocomplete = new google.maps.places.Autocomplete(
      (this.$refs.autocomplete),
      {types: ['geocode']}
    );
    this.autocomplete.addListener('place_changed', () => {
      let place = this.autocomplete.getPlace();
      let ac = place.address_components;
      let lat = place.geometry.location.lat();
      let lon = place.geometry.location.lng();
      let city = ac[0]["short_name"];
    });
  },
  data: function() {
    return {
      user_id: "",
      destination: "",
      home_airport: "",
      destination_airport: "",
      start_date: "",
      end_date: "",
      budget_flight: "",
      budget_accom: "",
      budget_food: "",
      budget_fun: "",
      errors: [],
      currentTrip: {
        user_id: "",
        destination: this.destination,
        home_airport: this.home_airport,
        destination_airport: this.destination_airport,
        start_date: this.start_date,
        end_date: this.end_date,
        budget_flight: "",
        budget_accom: "",
        budget_food: "",
        budget_fun: "",
      },
      flights: [],
      hotels: this.hotels,
      airports: usAirports,
    };
  },
  methods: {
    submit: function() {
      var params = {
        user_id: this.user_id,
        destination: this.destination,
        home_airport: this.home_airport,
        destination_airport: this.destination_airport,
        start_date: this.start_date,
        end_date: this.end_date,
        budget_flight: this.budget_flight,
        budget_accom: this.budget_accom,
        budget_food: this.budget_food,
        budget_fun: this.budget_fun,
      };
      axios
        .post("/v1/trips", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },
    setCurrentTrip: function(inputTrip) {
      this.currentTrip = inputTrip;
    },
    checkFlights: function() {
      var params = {
        home_airport: this.home_airport,
        destination_airport: this.destination_airport,
        start_date: this.start_date,
        end_date: this.end_date,
      };
      axios
        .get("/v1/flights", {params: params})
        .then(function(response) {
          this.flights = response.data;
        }.bind(this));
    },
    checkHotels: function() {
      var params = {
        destination: this.destination,
        start_date: this.start_date,
        end_date: this.end_date,
      };
      axios
        .get("/v1/hotels", {params: params})
        .then(function(response) {
          this.hotels = response.data;
        }.bind(this)
        );
    },
  }
};

var TripsShowPage = {
  template: "#trips-show-page",
  data: function() {
    return {
      trip: {
        user_id: "user_id",
        destination: "",
        home_airport: "",
        destination_airport: "",
        start_date: "start_date",
        end_date: "end_date",
        budget_flight: "budget_flight",
        budget_accom: "budget_accom",
        budget_food: "budget_food",
        budget_fun: "budget_fun",
      },
      inputTrip: {
        editTripDescription: "",
        editTripStartSate: "",
        editTripEndDate: "",
        editTripBudgetFlight: "",
        editTripBudgetAccom: "",
        editTripBudgetFood: "",
        editTripBudgetFun: "",
      }
    };
  },
  created: function() {
    axios.get("v1/trips/" + this.$route.params.id).then(
      function(response) {
        this.trip = response.data;
      }.bind(this)
    );
  },
  methods: {
    updateTrip: function(inputTrip) {
      var params = {};
      params.destination = this.editTripDescription;
      params.start_date = this.editTripStartSate;
      params.end_date = this.editTripEndDate;
      params.budget_flight = this.editTripBudgetFlight;
      params.budget_accom = this.editTripBudgetAccom;
      params.budget_food = this.editTripBudgetFood;
      params.budget_fun = this.editTripBudgetFun;

      axios.patch("v1/trips/" + inputTrip.id, params).then(
        function(response) {
          inputTrip.destination = response.data.destination;
          inputTrip.start_date = response.data.start_date;
          inputTrip.end_date = response.data.end_date;
          inputTrip.budget_flight = response.data.budget_flight;
          inputTrip.budget_accom = response.data.budget_accom;
          inputTrip.budget_food = response.data.budget_food;
          inputTrip.budget_fun = response.data.budget_fun;
          // this.editTripDescription = "";
          // this.editTripStartDate = "";
          // this.editTripEndDate = "";
          // this.editTripBudgetFlight = "";
          // this.editTripBudgetAccom = "";
          // this.editTripBudgetFood = "";
          // this.editTripBudgetFun = "";
        }.bind(this)
      );
    },
    deleteTrip: function(inputTrip) {
      axios.delete("v1/trips/" + inputTrip.id)
        .then(function(response) {
          console.log(response.data);
          router.push("/");
          var index = this.trip.indexOf(inputTrip);
          this.trip.splice(index, 1);
        });
    }
  },
  computed: {}
};

var ExpensesShowPage = {
  template: "#expenses-show-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      expenses: [],
      category: "",
      description: "",
      amount: "",
      sortAttribute: "category",
      sortAscending: true,
      currentExpense: {
        trip_id: this.trip_id,
        category: this.category,
        description: this.description,
        amount: this.amount
      },
    };
  },
  created: function() {
    axios.get("v1/expenses?trip_id=" + this.$route.query.trip_id).then(
      function(response) {
        this.expenses = response.data;
        console.log(this.expenses);
      }.bind(this)
    );
  },
  methods: {
    setCurrentExpense: function(inputExpense) {
      this.currentExpense = inputExpense;
    },
    submitExpense: function() {
      var params = {
        trip_id: this.trip_id,
        category: this.category,
        description: this.description,
        amount: this.amount
      };
      axios
        .post("v1/expenses?trip_id=" + this.$route.query.trip_id, params)
        .then(function(response) {
          this.expenses.push(response.data);
          this.category = '';
          this.description = '';
          this.amount = '';
        }.bind(this))
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },
    deleteExpense: function(inputExpense) {
      axios.delete("v1/expenses/" + inputExpense.id).then(function(response) {
        console.log(response.data);
        var index = this.expenses.indexOf(inputExpense);
        this.expenses.splice(index, 1);
      }.bind(this));
    },
    setSortAttribute: function(inputSortAttribute) {
      this.sortAttribute = inputSortAttribute;
      this.sortAscending = !this.sortAscending;
    }
  },
  computed: {
    sortedExpenses: function() {
      return this.expenses.sort(
        function(expense1, expense2) {
          if (this.sortAttribute === "amount") {
            var lower1 = expense1[this.sortAttribute];
            var lower2 = expense2[this.sortAttribute];
            if (this.sortAscending) {
              return lower1 - lower2;
            } else {
              return lower2 - lower1;
            }
          } else {
            var lowerArribute1 = expense1[this.sortAttribute];
            var lowerArribute2 = expense2[this.sortAttribute];
            if (this.sortAscending) {
              return lowerArribute1.localeCompare(lowerArribute2);
            } else {
              return lowerArribute2.localeCompare(lowerArribute1);
            }
          }
        }.bind(this)
      );
    }
  }
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/v1/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/trips/new", component: TripsNewPage },
    { path: "/trips/:id", component: TripsShowPage },
    { path: "/expenses", component: ExpensesShowPage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});
