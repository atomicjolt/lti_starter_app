import React           from 'react';
import DropDown        from './settings_drop_down';

export default class InstanceHeader extends React.Component {
  static propTypes = {
    newInstance: React.PropTypes.func.isRequired,
    instance: React.PropTypes.shape({
      name: React.PropTypes.string,
    }).isRequired,
  };

  static getStyles() {
    return {
      buttonIcon: {
        border: 'none',
        backgroundColor: 'transparent',
        color: 'grey',
        fontSize: '1em',
        cursor: 'pointer',
      },
    };
  }

  constructor() {
    super();
    this.state = { settingsOpen: false };
  }

  render() {
    const styles = InstanceHeader.getStyles();
    return (
      <div className="c-info">
        <div className="c-title">
          <h1>Instances</h1>
          <h3>{this.props.instance.name || 'App Name'}
            <button
              style={styles.buttonIcon}
              onClick={() => this.setState({ settingsOpen: !this.state.settingsOpen })}
            >
              <i className="i-settings" />
            </button>
          </h3>
          { this.state.settingsOpen ? <DropDown /> : null }
        </div>
        <button className="c-btn c-btn--yellow" onClick={this.props.newInstance}>
          New Instance
        </button>
      </div>
    );
  }
}
