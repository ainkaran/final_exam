import React from 'react';
import { Link } from 'react-router-dom';

function AuctionSummary (props) {
  const {id, title, created_at } = props;
  return (
    <div className='AuctionSummary'>
      <Link to={`/auctions/${id}`}>{title}</Link> • {created_at}
    </div>
  );
};

export default AuctionSummary;
