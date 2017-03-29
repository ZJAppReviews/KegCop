import React, {PropTypes} from 'react';
import NavBar from './common/NavBar-test';

var navbar = {};
navbar.brand =  {linkTo: "#", text: "KegCop"};
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
      <NavBar {...navbar} />
      <div id="diana">Hello, App!</div>
    </div>
  );
};

export default App;
