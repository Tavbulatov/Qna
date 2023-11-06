// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

import 'templates/comments'
import 'templates/questions'
import 'templates/links'
import 'templates/attachments'
import 'templates/_form_comment'
import 'templates/answers'
import 'templates/votes'

import "channels"
import '../helpers/handlebars'

import 'question'
import 'answer'
import 'gist'
import 'global'
import 'vote'
import 'comment'
import 'subscription'

require("jquery")
require("@nathanvda/cocoon")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
