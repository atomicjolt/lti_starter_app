import React               from 'react';
import _                   from 'lodash';

export default class Accounts extends React.Component {
  isActive(account) {
    const { activeAccounts } = this.props;
    return !!_.find(
      activeAccounts,
      activeAccount => activeAccount.id === account.id
    );
  }

  accounts(accounts, parentAccountId) {
    const currentAccounts = _(accounts)
      .filter({ parent_account_id: parentAccountId })
      .sortBy('name')
      .value();

    if (currentAccounts.length <= 0) {
      return null;
    }
    return _.map(currentAccounts, (account) => {
      const isActive = this.isActive(account);
      const children = this.accounts(accounts, account.id);
      return (
        <li
          key={`account_${account.id}`}
          className={isActive ? 'c-filter__item is-active' : 'c-filter__item'}
        >
          <button onClick={() => this.props.setAccountActive(account)}>
            { _.isNull(children) ? null : <i className="i-dropdown" />}
            {account.name}
          </button>
          {
            isActive ? <ul className="c-filter__dropdown">{children}</ul> : null
          }
        </li>
      );
    });
  }

  render() {
    // passing zero to keep track of how deep we are in the tree
    return (
      <ul className="c-filter-list">
        {this.accounts(this.props.accounts, null)}
      </ul>
    );
  }
}

Accounts.propTypes = {
  accounts         : React.PropTypes.shape({}).isRequired,
  setAccountActive : React.PropTypes.func.isRequired,
  activeAccounts   : React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
};
