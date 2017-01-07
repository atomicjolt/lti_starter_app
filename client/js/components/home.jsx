import React       from 'react';
import { connect } from 'react-redux';
import assets      from '../libs/assets';

const select = state => ({
  canvasOauthPath: state.settings.canvas_oauth_path
});

export class Home extends React.Component {

  authorize(){
    window.open(this.props.canvasOauthPath, 'Authenticate', 'width=600,height=600');
  }

  render(){
    const img = assets('./images/atomicjolt.jpg');
    return (
      <div>
        <img src={img} alt="Atomic Jolt Logo" />
        <a target="popup"
          onClick={e => this.authorize}
          href={this.props.canvasOauthPath}>Authorize Application</a>
      </div>
    );
  }
}

export default connect(select)(Home);