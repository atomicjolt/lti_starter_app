import _              from 'lodash';
import React          from 'react';
import { connect }    from 'react-redux';

const select = state => ({
  settings: state.settings
});

export class CanvasAuthentication extends React.Component {
  static propTypes = {
    settings: React.PropTypes.object.isRequired,
  };

  renderSettings() {
    return _.map(
      this.props.settings,
      (value, key) => <input key={key} type="hidden" value={value} name={key} />
    );
  }

  render() {
    return (
      <form action={this.props.settings.canvas_oauth_path}>
        <input type="submit" value="Authorize" />
        { this.renderSettings() }
      </form>
    );
  }
}

export default connect(select)(CanvasAuthentication);
