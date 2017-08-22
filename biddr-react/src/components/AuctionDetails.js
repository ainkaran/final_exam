import React from 'react';

function AuctionDetails (props) {
  const {id, title, details, bids = [], author = {}} = props;

  return (
    <div className='AuctionDetails'>
      <h2>{title}</h2>
      <p>{details}</p>
      <p><em>By {author.first_name} {author.last_name}</em></p>

      {/* <form action="bid_page">
        <input type="number" name="Bid">
        <input type="submit" value="Bid">
      </form> */}

      <h3>Previous Bids</h3>
      <ul className='BidList'>
        {
          bids.map(
            bid => (
              <li key={bid.id}>
                {bid.price} {bid.created_at}
              </li>
            )
          )
        }
      </ul>
    </div>
  )
}

export default AuctionDetails;
