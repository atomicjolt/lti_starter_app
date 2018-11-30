import * as React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import canvasRequest from 'atomic-canvas/libs/action';
import { listYourCourses } from 'atomic-canvas/libs/constants/courses';
import { withSettings } from 'atomic-fuel/libs/components/settings';

import { displayCanvasAuth } from '../../../common/components/common/canvas_auth';
import assets from '../libs/assets';
import Selector from './content_item_select/selector';

const select = state => ({
  courses: state.courses,
  canvasReAuthorizationRequired: state.canvasErrors.canvasReAuthorizationRequired,
});

export class Home extends React.Component {

  static propTypes = {
    settings: PropTypes.shape({
      canvas_auth_required: PropTypes.bool,
      lti_message_type: PropTypes.string,
      canvas_url: PropTypes.string,
    }).isRequired,
    canvasRequest: PropTypes.func.isRequired,
    courses: PropTypes.arrayOf(PropTypes.shape({
      id: PropTypes.number,
      name: PropTypes.string,
    })),
    canvasReAuthorizationRequired: PropTypes.bool,
  };

  componentDidMount() {
    if (!this.props.settings.canvas_auth_required) {
      // Example Canvas API call
      this.props.canvasRequest(listYourCourses);
    }
  }

  renderCourses() {
    if (!this.props.courses) {
      return null;
    }

    return this.props.courses.map((course) => {
      return (
        <li key={`course_${course.id}`}>
          <a target="_top" href={`${this.props.settings.canvas_url}/courses/${course.id}`}>
            {course.name}
          </a>
        </li>
      );
    });
  }

  renderContent() {
    const img = assets('./images/atomicjolt.jpg');

    if (this.props.settings.lti_message_type === 'ContentItemSelectionRequest') {
      return <Selector />;
    }

    return (
      <div>
        <img src={img} alt="Atomic Jolt Logo" />
        <hr />
        <ul>
          { this.renderCourses() }
        </ul>
      </div>
    );
  }

  render() {
    return (
      displayCanvasAuth(this.props.settings, this.props.canvasReAuthorizationRequired) ||
        this.renderContent()
    );
  }

}

export default withSettings(
  connect(select, { canvasRequest })(Home)
);
