import React            from 'react';
import { connect }      from 'react-redux';
import assets           from '../../../libs/assets';
import UserDropdown     from '../common/user_dropdown';

const select = (state, props) => ({
  userName: state.settings.display_name,
  signOutUrl: state.settings.sign_out_url,
});

export class heading extends React.Component {
  static propTypes = {
    back: React.PropTypes.func,
    userName: React.PropTypes.string,
    signOutUrl: React.PropTypes.string.isRequired,
  };

  constructor() {
    super();
    this.state = { showDropDown: false };
  }

  getStyles() {
    return {
      userName: {
        backgroundColor: 'transparent',
        border: 'none',
        cursor: 'pointer'
      }
    };
  }

  render() {
    const img = assets('./images/atomicjolt.svg');
    const styles = this.getStyles();

    return (
      <header className="c-head">
        <div className="c-back">
          {
            this.props.back ? <button className="c-btn c-btn--back" onClick={this.props.back}>
              <i className="i-back" />
              Back
            </button> : null
          }
        </div>
        <img className="c-logo" src={img} alt="Atomic Jolt Logo" />
        <ul className="c-user">
          <li>
            <button
              className="c-username"
              style={styles.userName}
              onClick={() => this.setState({ showDropDown: !this.state.showDropDown })}
            >
              {this.props.userName}
              <i className="i-dropdown" />
            </button>
          </li>
        </ul>
        {this.state.showDropDown ? <UserDropdown signOutUrl={this.props.signOutUrl} /> : null }
      </header>
    );
  }
}


export default connect(select)(heading);