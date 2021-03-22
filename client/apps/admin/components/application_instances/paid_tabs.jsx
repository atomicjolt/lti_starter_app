import React from 'react';
import PropTypes from 'prop-types';

export default function PaidTabs(props) {
  const {
    changeTab,
    showPaid,
  } = props;

  return (
    <div className="aj-flex">
      <button
        onClick={() => changeTab(true)}
        className={showPaid ? 'c-tab-btn active' : 'c-tab-btn'}
      >
        PAID
      </button>
      <button
        onClick={() => changeTab(false)}
        className={showPaid ? 'c-tab-btn' : 'c-tab-btn active'}
      >
        EVALS
      </button>
    </div>
  );
}

PaidTabs.propTypes = {
  changeTab: PropTypes.func,
  showPaid: PropTypes.bool,
};
