import React, { PropTypes } from 'react';
// import { Link, IndexLink } from 'react-router';
// import { browserHistory, Router, Route } from 'react-router';

// create classes
var NavBar = React.createClass({
  render: function(){
    return(
      <nav className="navbar navbar-default navbar-static-top">
        <div className="container-fluid">
          <div className="navbar-header">
            <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <NavBrand linkTo={this.props.brand.linkTo} text={this.props.brand.text} />
          </div>
          <div className="collapse navbar-collapse" id="navbar-collapse">
            <NavMenu links={this.props.links} />
          </div>
        </div>
      </nav>
    );
  }
});

var NavBrand = React.createClass({
  render: function(){
    return (
      <a className="navbar-brand" href={this.props.linkTo}>{this.props.text}</a>
    );
  }
});

var NavMenu = React.createClass({
  render: function(){
    var links = this.props.links.map(function(link){
      if(link.dropdown) {
        return (
          <NavLinkDropdown key={link.text} links={link.links} text={link.text} active={link.active} icon={link.icon} />
        );
      }
      else {
        return (
          <NavLink key={link.text} linkTo={link.linkTo} text={link.text} active={link.active} />
        );
      }
    });
    return (
      <ul className="nav navbar-nav">
        {links}
      </ul>
    );
  }
});

var NavLinkDropdown = React.createClass({
  render: function(){
    var active = false;
    var links = this.props.links.map(function(link){
      if(link.active){
        active = true;
      }
      return (
        <NavLink key={link.text} linkTo={link.linkTo} text={link.text} active={link.active} />
      );
    });
    return (
      <li className={"dropdown " + (active ? "active" : "")}>
        <a href="#" className="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
          {this.props.text}
          <span className="caret"></span>
        </a>
        <ul className="dropdown-menu">
          {links}
        </ul>
      </li>
    );
  }
});

var NavLink = React.createClass({
  render: function(){
    return(
      <li className={(this.props.active ? "active" : "")}>
        <a href={this.props.linkTo}>{this.props.text}{this.props.icon}</a>
      </li>
    );
  }
});

// var NavLink = React.createClass({
//   render: function(){
//     return(
//       <li className={(this.props.active ? "active" : "")}>
//
//       <Link to={ this.props.linkTo }>
//           <span className="NavLink">{this.props.text} {this.props.icon}</span>
//       </Link>
//       </li>
//     );
//   }
// });

// <a href={this.props.linkTo}>{this.props.text}</a>

// set data
// var navbar = {};
// navbar.brand =
//   {linkTo: "#", text: "React Bootstrap Navbar"};
// navbar.links = [
//   {linkTo: "#", text: "Link 1"},
//   {linkTo: "#", text: "Link 2"},
//   {dropdown: true, text: "Dropdown", links: [
//     {linkTo: "#", text: "Dropdown Link 1"},
//     {linkTo: "#", text: "Dropdown Link 2", active: true}
//   ]}
// ];

export default NavBar;
