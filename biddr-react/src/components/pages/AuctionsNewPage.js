import React, {Component} from 'react';
import {Auction} from '../../utilities/requests';
import AuctionForm from '../AuctionForm';

class AuctionsNewPage extends Component {
  constructor (props) {
    super(props);

    this.createAuction = this.createAuction.bind(this);
  }

  createAuction (auction) {
    Auction
      .post(auction)
      .then(({id}) => this.props.history.push(`/auctions/${id}`));
  }

  render () {
    return (
      <div className='AuctionsNewPage'>
        <h2>New Auction</h2>
        <AuctionForm onSubmit={this.createAuction} />
      </div>
    );
  }
}

export default AuctionsNewPage;
