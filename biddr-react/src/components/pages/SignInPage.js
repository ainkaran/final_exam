import React, {Component} from 'react';
import {Token} from '../../utilities/requests';
import SignInForm from '../SignInForm';

class SignInPage extends Component {
  constructor (props) {
    super(props);
    this.createToken = this.createToken.bind(this);
  }

  createToken (params) {
    const {onSignIn = () => {}} = this.props;
    Token
      .post(params)
      .then(({jwt}) => {
        // console.log(res);
        window.localStorage.setItem('jwt', jwt);
        this.props.history.push(`/`);
        onSignIn();
      })
  }

  render () {
    return (
      <div className='SignInPage'>
        <h2>Sign In</h2>
        <SignInForm onSubmit={this.createToken} />
      </div>
    );
  }
}

export default SignInPage;
