import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App.js';
import './components/App.css';
import './styles/styles.css';
import ReactGA from 'react-ga';
ReactGA.initialize('UA-43223650-1');

ReactGA.set({ page: window.location.pathname });
ReactGA.pageview(window.location.pathname);

// Take this component's generated HTML
// and put it on the page (in the DOM)
ReactDOM.render(<App onUpdate={logPageView} />, document.getElementById('root'));
