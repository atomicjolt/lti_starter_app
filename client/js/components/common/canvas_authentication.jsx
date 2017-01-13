import React       from 'react';
import { connect } from 'react-redux';

const select = state => ({
  canvasOauthPath: state.settings.canvas_oauth_path
});

export class CanvasAuthentication extends React.Component {

  authorize(){
    window.open(this.props.canvasOauthPath, 'Authenticate', 'width=600,height=600');
  }

  render(){
    return (
      <a target="popup"
        onClick={e => this.authorize}
        href={this.props.canvasOauthPath}>Authorize Application</a>
    );
  }
}

export default connect(select)(Home);