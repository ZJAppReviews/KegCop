import React, {PropTypes} from 'react';
import NavBar from './common/NavBar-test';

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
      <div id="iphone">
        
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
