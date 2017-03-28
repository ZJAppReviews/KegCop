import React from 'react';
import styles from './App.css';
import NavBar from './common/Navbar';
// import NavLink from './common/NavLink';

var navbar = {};
navbar.brand = {linkTo: "/", text: "chrisrjones.com"};
navbar.links = [
    {linkTo: "/about", text: "About Me"},
    {linkTo: "/contact", text: "Contact" },
    {dropdown: true, text: "Contribute",  links: [
        {linkTo: "signup", text: "Sign Up" },
        {linkTo: "login", text: "Login" }
    ]}
];

const App = () => (
  <div className={styles.app}>
    <NavBar {...navbar}/>
    <h2>Hello, KegCop!</h2>
    {this.props.children}
  </div>
);

App.propTypes = {
	children: PropTypes.object.isRequired
};

export default App;
