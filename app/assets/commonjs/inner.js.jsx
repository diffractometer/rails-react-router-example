import { default as React } from "react";
import { Link } from "react-router";

var Inner = React.createClass({
  render () {
    return (
      <div>
        <div className="navbar navbar-default">
          <div className="container-fluid">
            <div className="navbar-header">
              <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span className="sr-only">Toggle navigation</span>
                <span className="icon-bar"></span>
                <span className="icon-bar"></span>
                <span className="icon-bar"></span>
              </button>
              <a className="navbar-brand" href="#">Rails React Router Example</a>
            </div>

            <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              <ul className="nav navbar-nav">
                <li><Link to="home">Home</Link></li>
                <li><Link to="login">Login</Link></li>        
              </ul>
            </div>
          </div>
        </div>
      </div>
    )
  }
});

module.exports = Inner;
