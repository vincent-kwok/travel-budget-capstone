/* global Vue, VueRouter, axios, google */

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
    // console.log("gonna grab some trips....")
    // var cachedTripsString = localStorage.getItem("cachedTrips");
    // if (useCachedTrips && cachedTripsString) {
    //   this.trips = JSON.parse(cachedTripsString);
    //   console.log("trips retrieved from cache");
    // } else {
    axios.get("/v1/trips").then(
      function(response) {
        this.trips = response.data;
        localStorage.setItem("cachedTrips", JSON.stringify(response.data));
        console.log("trips retrieved from api");
      }.bind(this)
    );
    // }
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

      console.log(`The user picked ${city} with the coordinates ${lat}, ${lon}`);
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
      flights: this.flights,
    };
  },
  created: function() {
    axios.get("http://developer.goibibo.com/api/search/?app_id=32e4551b&app_key=5a51d0b0ff157bae5674f87076e24c92&format=json&source=lga&destination=ord&dateofdeparture=20180602&dateofarrival=20180612&seatingclass=E&adults=1&children=0&infants=0&counter=100").then(
      function(response) {
        this.trips = response.data;
      }.bind(this)
    );
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
      console.log(params);
      axios
        .get("/v1/flights", {params: params})
        .then(function(response) {
          this.flights = response.data;
          console.log('flight data', this.flights);
        }.bind(this)
        );
    },
    checkHotels: function() {
      var params = {
        destination: this.destination,
        start_date: this.start_date,
        end_date: this.end_date,
      };
      console.log(params);
      axios
        .get("/v1/hotels", {params: params})
        .then(function(response) {
          this.hotels = response.data;
          console.log('hotel data', this.hotels);
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
        budget_fun: "budget_fun"
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
  methods: {},
  computed: {}
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
