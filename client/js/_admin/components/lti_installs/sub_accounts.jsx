import React               from 'react';
import _                   from 'lodash';

export default class SubAccounts extends React.Component {
  isActive(account) {
    const { activeAccounts } = this.props;
    return !!_.find(
      activeAccounts,
      activeAccount => activeAccount.id === account.id
    );
  }

  accounts(accounts, depth) {
    return _.map(accounts, (account) => {
      const isActive = this.isActive(account);

      return (
        <li
          key={`account_${account.id}`}
          className={isActive ? 'c-filter__item is-active' : 'c-filter__item'}
        >
          <button onClick={() => this.props.setAccountActive(account, depth)}>
            { _.size(account.sub_accounts) > 0 ? <i className="i-dropdown" /> : null }
            {account.name}
          </button>
          {
            isActive ? <ul className="c-filter__dropdown">
              {this.accounts(account.sub_accounts, depth + 1)}
            </ul> : null
          }
        </li>
      );
    });
  }

  render() {
    // passing zero to keep track of how deep we are in the tree
    return (
      <ul className="c-filter__dropdown">
        {this.accounts(this.props.accounts, 0)}
      </ul>
    );
  }
}

SubAccounts.propTypes = {
  accounts         : React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
  setAccountActive : React.PropTypes.func.isRequired,
  activeAccounts   : React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
};
