// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import Handlebars from 'handlebars';
// const templates = require.context('../templates', true, /\.hbs$/);
// templates.keys().forEach(templates);

import "channels"

import 'question'
import 'answer'
import 'gist'
import 'global'
import 'vote'
import "channels/tests"
require("jquery")
require("@nathanvda/cocoon")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
// questionTemplate = require('../templates/question.hbs')
// let tem = Handlebars.compile(questionTemplate)

// console.log(questionTemplate)
