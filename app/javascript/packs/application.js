// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "bootstrap";
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'jquery'
import 'popper.js'
import "@fortawesome/fontawesome-free/js/all"
import 'bootstrap/dist/js/bootstrap'
import "trix"
import "@rails/actiontext"


// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "../stylesheets/application.scss";
document.addEventListener("turbolinks:load", function () {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip();
        $('[data-toggle="popover"]').popover();
    });
});

