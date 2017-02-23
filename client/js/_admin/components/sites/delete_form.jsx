import React from 'react';

const SiteForm = props => (
  <form>
    <button
      type="button"
      className="c-btn c-btn--red"
      onClick={() => props.deleteSite()}
    >
      Yes
    </button>
    <button
      type="button"
      className="c-btn c-btn--gray--large u-m-right"
      onClick={() => props.closeModal()}
    >
      Cancel
    </button>
  </form>
);

SiteForm.propTypes = {
  deleteSite: React.PropTypes.func.isRequired,
  closeModal: React.PropTypes.func.isRequired,
};

export default SiteForm;
