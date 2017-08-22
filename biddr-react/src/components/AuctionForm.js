import React from 'react';

function AuctionForm (props) {
  const {onSubmit = () => {}} = props;

  const handleSubmit = event => {
    event.preventDefault();
    const {currentTarget} = event;

    const formData = new FormData(currentTarget);
    onSubmit({
      title: formData.get('title'),
      details: formData.get('details'),
      end_date: formData.get('end_date'),
      price: formData.get('price')
    });
  }

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label htmlFor='title'>Title</label> <br />
        <input id='title' name='title' />
      </div>

      <div>
        <label htmlFor='details'>Details</label> <br />
        <textarea id='details' name='details' />
      </div>

      <div>
        <label htmlFor='end_date'>Ends On</label> <br />
        <date id='end_date' name='end_date' />
      </div>

      <div>
        <label htmlFor='price'>Reserve Price</label> <br />
        <number id='price' name='price' />
      </div>

      <div>
        <input type='submit' value='Submit'/>
      </div>
    </form>
  );
}

export default AuctionForm;
