import { default as React } from "react";
import { Router, Route, Link } from "react-router";
import { history } from 'react-router/lib/HashHistory';
import { default as Inner } from "./inner";
import { default as Home } from "./pages/home";
import { default as Login } from "./pages/login";

var AppClient = React.createClass({
  componentDidMount () {
    console.log("app component mounted");
  },

  render () {
    return (
      <div>
        <Inner /> 
        {this.props.children}
      </div>
    );
  }

});

// declare our routes and their hierarchy
var routes = {
  path: "/",
  component: AppClient,
  childRoutes: [
    {path: "home", component: Home},
    {path: "login", component: Login}
  ]
};

var initialize = function(mountNode) {
  React.render(<Router history={history} children={routes} />, mountNode);
};

module.exports = initialize;
