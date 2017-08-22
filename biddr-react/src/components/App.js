import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
  Switch
} from 'react-router-dom';
import jwtDecode from 'jwt-decode';
import AuthRoute from './AuthRoute';
import AuctionsIndexPage from './pages/AuctionsIndexPage';
import AuctionsShowPage from './pages/AuctionsShowPage';
import AuctionsNewPage from './pages/AuctionsNewPage';
import SignInPage from './pages/SignInPage';
import HomePage from './pages/HomePage';

class App extends Component {
  constructor (props) {
    super(props);

    this.state = {
      isSignedIn: false
    };

    this.signOut = this.signOut.bind(this);
    this.signIn = this.signIn.bind(this);
  }

  componentDidMount () {
    this.setState({isSignedIn: !!window.localStorage.getItem('jwt')});
  }

  signOut (event) {
    event.preventDefault();
    window.localStorage.removeItem('jwt');
    // this.forceUpdate();
    this.setState({isSignedIn: false});
  }

  signIn () {
    this.setState({isSignedIn: true});
  }

  get currentUser () {
    const jwt = window.localStorage.getItem('jwt');
    return jwt && jwtDecode(jwt);
  }

  render() {
    const {currentUser} = this;
    const {isSignedIn} = this.state;

    return (
      <Router>
        <div className="App">
          <nav>
            <Link to='/'>Home</Link>
            <Link to='/auctions'>Auctions</Link>
            <Link to='/auctions/new'>New Auction</Link>
            {
              // this.isSignedIn()
              isSignedIn
              ? ([
                <span key={0}>
                  Hello, {currentUser.firstName} {currentUser.lastName}!
                </span>,
                <a key={1} href onClick={this.signOut}>
                  Sign out
                </a>
              ]) : (
                <Link to='/sign_in'>Sign In</Link>
              )
            }
          </nav>
          <h1>Biddr</h1>
          <Switch>
            <Route exact path='/' component={HomePage} />
            <Route
              exact
              path='/sign_in'
              render={props => <SignInPage {...props} onSignIn={this.signIn} />} />
            <AuthRoute
              exact
              isAuthenticated={isSignedIn}
              path='/auctions'
              component={AuctionsIndexPage} />
            <AuthRoute
              exact
              isAuthenticated={isSignedIn}
              path='/auctions/new'
              component={AuctionsNewPage} />
            <AuthRoute
              isAuthenticated={isSignedIn}
              path='/auctions/:id'
              component={AuctionsShowPage} />
          </Switch>
        </div>
      </Router>
    );
  }
}

export default App;
