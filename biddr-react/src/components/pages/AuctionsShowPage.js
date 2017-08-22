import React, {Component} from 'react';
import {Auction} from '../../utilities/requests';
import AuctionDetails from '../AuctionDetails';

class AuctionsShowPage extends Component {
  constructor (props) {
    super(props);

    this.state = {
      auction: {}
    };
  }

  componentDidMount () {
    const {id} = this.props.match.params;

    Auction
      .get(id)
      .then(auction => this.setState({auction}));
  }

  render () {
    return (
      <div className='AuctionsShowPage'>
        <AuctionDetails {...this.state.auction} />
      </div>


    );
  }
}

export default AuctionsShowPage;
