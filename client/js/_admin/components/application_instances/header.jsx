import React           from 'react';
import DropDown        from './settings_drop_down';

export default class Header extends React.Component {
  static propTypes = {
    newApplicationInstance: React.PropTypes.func.isRequired,
    instance: React.PropTypes.shape({
      name: React.PropTypes.string,
    }),
  };

  render() {
    const { instance, newApplicationInstance } = this.props;

    return (
      <div className="c-info">
        <div className="c-title">
          <h1>{instance ? instance.name : 'App Name'} Instances</h1>
        </div>
        <button className="c-btn c-btn--yellow" onClick={newApplicationInstance}>
          New Application Instance
        </button>
      </div>
    );
  }
}
