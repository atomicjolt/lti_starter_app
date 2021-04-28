import * as React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import canvasRequest from 'atomic-canvas/libs/action';
import { listYourCourses } from 'atomic-canvas/libs/constants/courses';
import { withSettings } from 'atomic-fuel/libs/components/settings';

import { displayCanvasAuth } from '../../../common/components/common/canvas_auth';
import assets from '../libs/assets';
import Selector from './content_item_select/selector';
import DeepLink from './deep_link';

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

    return this.props.courses.map(course =>
      <li key={`course_${course.id}`}>
        <a target="_top" href={`${this.props.settings.canvas_url}/courses/${course.id}`}>
          {course.name}
        </a>
      </li>);
  }

  renderLineItemErrors() {
    return this.props.settings.line_items.errors.map(error =>
      <li key={error.message}>{error.message}</li>);
  }

  renderLineItems() {
    if (!this.props.settings.line_items) {
      return null;
    }

    if (this.props.settings.line_items.errors) {
      return (
        <div>
          <h3>Errors:</h3>
          <ul>{this.renderLineItemErrors()}</ul>
        </div>
      );
    }

    return this.props.settings.line_items.map(lineItem =>
      <li key={`line_item${lineItem.id}`}>
        <a href={lineItem.id}>
          {lineItem.label} ({lineItem.scoreMaximum})
        </a>
      </li>);
  }

  renderUsers() {
    if (!this.props.settings.names_and_roles) {
      return null;
    }
    return this.props.settings.names_and_roles.members.map(nameAndRole =>
      <li key={`name_and_role_${nameAndRole.user_id}`}>
        <a target="_top" href={`${this.props.settings.canvas_url}/courses/${nameAndRole.id}`}>
          {nameAndRole.user_id}
          <img src={nameAndRole.picture} alt={nameAndRole.given_name} />
        </a>
        <p>Name: {nameAndRole.name || 'Anonymous'}</p>
        <p>Email: {nameAndRole.email}</p>
        <p>Status: {nameAndRole.status}</p>
        <p>User Id:{nameAndRole.userId}</p>
        <p>Roles:{nameAndRole.roles.join(', ')}</p>
      </li>);
  }

  renderResults() {
    if (!this.props.settings.line_item_results) {
      return null;
    }

    return this.props.settings.line_item_results.map(result =>
      <li key={`name_and_role_${result.id}`}>
        <p>User: {result.userId}</p>
        <p>Score: {result.resultScore}/{result.resultMaximum}</p>
        <p>Comment: {result.comment}</p>
      </li>);
  }

  renderContent() {
    const img = assets('./images/atomicjolt.jpg');

    if (this.props.settings.lti_message_type === 'ContentItemSelectionRequest') {
      return <Selector />;
    }

    if (this.props.settings.deep_link_settings) {
      return (
        <DeepLink
          deepLinkSettings={this.props.settings.deep_link_settings}
        />
      );
    }

    return (
      <div>
        <img src={img} alt="Atomic Jolt Logo" />
        <hr />
        <h2>Courses:</h2>
        <ul>
          { this.renderCourses() }
        </ul>
      </div>
    );
  }

  renderLtiAdvantageExamples() {
    if (this.props.settings.deep_link_settings) {
      return null;
    }

    return (
      <div>
        <hr />
        <h3>Users (LTI Advantage names and roles example):</h3>
        <ul style={{ textAlign: 'left' }}>
          { this.renderUsers() }
        </ul>
        <h3>Line items (LTI Advantage line items example):</h3>
        <ul style={{ textAlign: 'left' }}>
          { this.renderLineItems() }
        </ul>
        <h3>Results (LTI Advantage line item results example):</h3>
        <ul style={{ textAlign: 'left' }}>
          { this.renderResults() }
        </ul>
      </div>
    );
  }

  render() {
    const content = displayCanvasAuth(
      this.props.settings,
      this.props.canvasReAuthorizationRequired
    ) || this.renderContent();

    return (
      <div>
        { content }
        { this.renderLtiAdvantageExamples() }
      </div>
    );
  }

}

export default withSettings(
  connect(select, { canvasRequest })(Home)
);
