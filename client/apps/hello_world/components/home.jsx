import * as React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import Auth from 'atomic-canvas/libs/components/canvas_authentication';
import canvasRequest from 'atomic-canvas/libs/action';
import { listYourCourses } from 'atomic-canvas/libs/constants/courses';

import assets from '../libs/assets';
import Selector from './content_item_select/selector';

const select = state => ({
  canvasAuthRequired: state.settings.canvas_auth_required,
  ltiMessageType: state.settings.lti_message_type,
  courses: state.courses,
  canvasReAuthorizationRequired: state.canvasErrors.canvasReAuthorizationRequired,
  canvasUrl: state.settings.canvas_url,
});

export class Home extends React.Component {

  static propTypes = {
    canvasAuthRequired: PropTypes.bool,
    ltiMessageType: PropTypes.string,
    canvasRequest: PropTypes.func.isRequired,
    canvasUrl: PropTypes.string,
    courses: PropTypes.arrayOf(PropTypes.shape({
      id: PropTypes.number,
      name: PropTypes.string,
    })),
    canvasReAuthorizationRequired: PropTypes.bool,
  };

  componentDidMount() {
    if (!this.props.canvasAuthRequired) {
      // Example Canvas API call
      this.props.canvasRequest(
        listYourCourses,
      );
    }
  }

  renderCourses() {
    if (!this.props.courses) {
      return null;
    }

    return this.props.courses.map((course) => {
      return (
        <li key={`course_${course.id}`}>
          <a target="_top" href={`${this.props.canvasUrl}/courses/${course.id}`}>
            {course.name}
          </a>
        </li>
      );
    });
  }

  render() {
    const img = assets('./images/atomicjolt.jpg');
    const authRequired = this.props.canvasAuthRequired || this.props.canvasReAuthorizationRequired;

    if (this.props.ltiMessageType === 'ContentItemSelectionRequest') {
      return <Selector />;
    }

    return (
      <div>
        <img src={img} alt="Atomic Jolt Logo" />
        <hr />
        { authRequired ? <Auth /> : 'You have authenticated with Canvas' }
        <ul>
          { this.renderCourses() }
        </ul>
      </div>
    );
  }

}

export default connect(select, { canvasRequest })(Home);
