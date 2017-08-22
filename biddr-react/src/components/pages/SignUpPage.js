import React, {Component} from 'react';
import {Token} from '../../utilities/requests';
import SignUpForm from '../SignUpForm';

class SignUpPage extends Component {
  constructor (props) {
    super(props);
    this.createToken = this.createToken.bind(this);
  }

  createToken (params) {
    const {onSignUp = () => {}} = this.props;
    Token
      .post(params)
      .then(({jwt}) => {
        // console.log(res);
        window.localStorage.setItem('jwt', jwt);
        this.props.history.push(`/`);
        onSignUp();
      })
  }

  render () {
    return (
      <div className='SignUpPage'>
        <h2>Sign Up</h2>
        <SignUpForm onSubmit={this.createToken} />
      </div>
    );
  }
}

export default SignUpPage;
