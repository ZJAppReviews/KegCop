import React, {PropTypes} from 'react';
import styles from './App.css';
import NavBar from './common/NavBar-test';
import NavLink from './common/NavLink';

var navbar = {};
navbar.brand =  {linkTo: "#", text: "React Bootstrap Navbar"};
navbar.links = [
  {linkTo: "#", text: "Link 1"},
  {linkTo: "#", text: "Link 2"},
  {dropdown: true,text: "Dropdown",links: [
    {linkTo: "#", text: "Dropdown Link 1"},
    {linkTo: "#", text: "Dropdown Link 2", active: true}
  ]}
];

// Create a new component.  This component should produce some HTML.
const App = (props) => {
  return (
    <div id="parent">
      <div>Hello, App!</div>
      <NavBar {...navbar} />

    </div>
  );
};

export default App;
