import React from 'react';
import AuctionSummary from './AuctionSummary';

function AuctionList (props) {
  const {auctions = []} = props;

  return (
    <div className='AuctionList'>
      {
        auctions.map(
          auction => <AuctionSummary key={auction.id} {...auction} />          
        )
      }
    </div>
  );
}

export default AuctionList;
