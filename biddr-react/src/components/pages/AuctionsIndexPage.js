import React, {Component} from 'react';
import {Auction} from '../../utilities/requests';
import AuctionList from '../AuctionList';

class AuctionsIndexPage extends Component {
  constructor (props) {
    super(props);

    this.state = {
      auctions: []
    };
  }

  componentDidMount () {
    Auction
      .getAll()
      .then(auctions => this.setState({auctions}));
  }

  render () {
    return (
      <div className='AuctionsIndexPage'>
        <h2>Auctions</h2>
        <AuctionList auctions={this.state.auctions} />
      </div>
    );
  }
}

export default AuctionsIndexPage;
