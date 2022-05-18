import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';

export default function SubAccount(props) {
  const {
    accounts,
    account,
    isActive,
    currentAccount,
    setAccountActive
  } = props;

  const [open, setOpen] = useState(false);
  const [hasToggled, setHasToggled] = useState(false);

  useEffect(() => {
    if (currentAccount === account && !hasToggled) {
      setOpen(true);
    }
  }, [currentAccount, account, hasToggled]);

  const getChildrenAccounts = () => _(accounts)
    .filter({ parent_account_id: account.id })
    .sortBy('name')
    .map((child) => (
      <SubAccount
        key={`account_${child.id}`}
        account={child}
        setAccountActive={setAccountActive}
        accounts={accounts}
        currentAccount={currentAccount}
        isActive={currentAccount && child.id === currentAccount.id}
      />
    ))
    .value();

  const handleAccountClick = () => {
    setOpen(!open);
    setHasToggled(true);
    setAccountActive(account);
  };

  const childrenAccounts = getChildrenAccounts();
  return (
    <li
      key={`account_${account.id}`}
      className={isActive ? 'c-filter__item is-active' : 'c-filter__item'}
    >
      <button
        type="button"
        onClick={handleAccountClick}
      >
        { childrenAccounts.length ? <i className={open ? 'i-dropdown is-open' : 'i-dropdown'} /> : null }
        {account.name}
      </button>
      {
          open ? <ul className="c-filter__dropdown">{childrenAccounts}</ul> : null
        }
    </li>
  );
}

SubAccount.propTypes = {
  accounts: PropTypes.shape({}).isRequired,
  account: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
  }).isRequired,
  isActive: PropTypes.bool,
  currentAccount: PropTypes.shape({
    id: PropTypes.number
  }),
  setAccountActive: PropTypes.func.isRequired,
};
