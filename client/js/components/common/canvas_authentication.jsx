import _              from 'lodash';
import React          from 'react';
import { connect }    from 'react-redux';

const select = state => ({
  settings: state.settings
});

export class CanvasAuthentication extends React.Component {
  static defaultProps = {
    overrides  : {},
    hideButton : false,
    autoSubmit : false,
  }

  static propTypes = {
    overrides  : React.PropTypes.shape({}),
    hideButton : React.PropTypes.bool,
    autoSubmit : React.PropTypes.bool,
    settings   : React.PropTypes.shape({
      canvas_oauth_path: React.PropTypes.string,
    }).isRequired,
  }

  componentDidMount() {
    if (this.props.autoSubmit) {
      this.form.submit();
    }
  }

  getButton() {
    if (this.props.hideButton) return null;
    return <input type="submit" value="Authorize" />;
  }

  renderSettings() {
    const settings = { ...this.props.settings, ...this.props.overrides };
    return _.map(settings, (value, key) => (
      <input key={key} type="hidden" value={value} name={key} />
    ));
  }

  render() {
    return (
      <form
        ref={(ref) => { this.form = ref; }}
        action={this.props.settings.canvas_oauth_path}
      >
        { this.getButton() }
        { this.renderSettings() }
      </form>
    );
  }
}

export default connect(select)(CanvasAuthentication);
