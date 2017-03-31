import React, {PropTypes} from 'react';
import NavBar from './common/NavBar-test';
import iPhone from '../images/iphone-template.png';
import ReactGA from 'react-ga';
ReactGA.initialize('UA-43223650-1');

var navbar = {};
navbar.brand =  {linkTo: "#", text: "KegCop"};
navbar.links = [
  {linkTo: "#", text: "Demonstration"},
  {linkTo: "#", text: "Demonstration #2"}
];

// Create a new component.  This component should produce some HTML.
const App = (props) => {
  return (
    <div id="parent">
      <NavBar {...navbar} />
      {/* see scratchpad.txt for removed div. */}
      <div id="container">

        <div className="box" id="bluebox">
            <div id="iphone">
              <img className="iphone-template" src={iPhone} />
            </div>
        </div>

          <div className="box" id="redbox">
            <div id="message">
              <h1>An iOS app for your kegerator!</h1>
              <h4>KegCop is an open source iOS application that monitors a kegerator
           by having drinkers create user accounts associated with the kegerator.
           The admin of the kegerator will login with the root account,
          and then issue credits to the users of the kegerator.</h4>
            </div>
          </div>
      </div>

      <div id="wilson">
        <div className="embed-responsive embed-responsive-4by3">
          <iframe className="embed-responsive-item"
                src="https://www.youtube.com/embed/1a6hxUb3zfU"
                frameBorder="0" allowFullScreen>
          </iframe>
        </div>
      </div> {/* wilson */}
      {/* insert video #2 below */}
      <div id="chris">
        <div className="embed-responsive embed-responsive-4by3">
          <iframe className="embed-responsive-item"
                src="https://www.youtube.com/embed/tNWhGGUwZjg"
                frameBorder="0" allowFullScreen>
          </iframe>
        </div>
      </div> {/* chris */}
    </div>

  );
};



export default App;
