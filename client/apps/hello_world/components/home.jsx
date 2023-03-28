import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { useSelector, useDispatch } from 'react-redux';
import canvasRequest from 'atomic-canvas/libs/action';
import { listYourCourses } from 'atomic-canvas/libs/constants/courses';
import useSettings from 'atomic-fuel/libs/hooks/use_settings';

import { displayCanvasAuth } from '../../../common/components/common/canvas_auth';
import Selector from './content_item_select/selector';
import DeepLink from './deep_link';

import img from '../assets/images/atomicjolt.jpg';

function CourseList({ canvasUrl }) {
  const dispatch = useDispatch();
  const settings = useSettings();
  const courses = useSelector((state) => state.courses);

  useEffect(() => {
    if (!settings.canvas_auth_required) {
      // Example Canvas API call
      dispatch(canvasRequest(listYourCourses));
    }
  }, [settings.canvas_auth_required, canvasRequest]);

  if (!courses) {
    return null;
  }

  return courses.map((course) => (
    <li key={`course_${course.id}`}>
      <a target="_top" href={`${canvasUrl}/courses/${course.id}`}>
        {course.name}
      </a>
    </li>
  ));
}

function LineItemErrors({ errors }) {
  return errors.map((error) => <li key={error.message}>{error.message}</li>);
}

function LineItems({ lineItems }) {
  if (!lineItems) {
    return null;
  }

  if (lineItems.errors) {
    return (
      <div>
        <h3>Errors:</h3>
        <ul>
          <LineItemErrors errors={lineItems.errors} />
        </ul>
      </div>
    );
  }

  return lineItems.map((lineItem) => (
    <li key={`line_item${lineItem.id}`}>
      <a href={lineItem.id}>
        {lineItem.label}
        {' '}
        (
        {lineItem.scoreMaximum}
        )
      </a>
    </li>
  ));
}

function Users({ namesAndRoles, canvasUrl }) {
  if (!namesAndRoles) {
    return null;
  }

  return namesAndRoles.members.map((nameAndRole) => (
    <li key={`name_and_role_${nameAndRole.user_id}`}>
      <a target="_top" href={`${canvasUrl}/courses/${nameAndRole.id}`}>
        {nameAndRole.user_id}
        <img src={nameAndRole.picture} alt={nameAndRole.given_name} />
      </a>
      <p>
        Name:
        {nameAndRole.name || 'Anonymous'}
      </p>
      <p>
        Email:
        {nameAndRole.email}
      </p>
      <p>
        Status:
        {nameAndRole.status}
      </p>
      <p>
        User Id:
        {nameAndRole.userId}
      </p>
      <p>
        Roles:
        {nameAndRole.roles.join(', ')}
      </p>
    </li>
  ));
}

function Results({ lineItemResults }) {
  if (!lineItemResults) {
    return null;
  }

  return lineItemResults.map((result) => (
    <li key={`name_and_role_${result.id}`}>
      <p>
        User:
        {result.userId}
      </p>
      <p>
        Score:
        {' '}
        {result.resultScore}
        /
        {result.resultMaximum}
      </p>
      <p>
        Comment:
        {result.comment}
      </p>
    </li>
  ));
}

function Examples({ settings }) {
  if (settings.deep_link_settings) {
    return null;
  }

  return (
    <div>
      <hr />
      <h3>Users (LTI Advantage names and roles example):</h3>
      <ul style={{ textAlign: 'left' }}>
        <Users namesAndRoles={settings.names_and_roles} canvasUrl={settings.canvas_url} />
      </ul>
      <h3>Line items (LTI Advantage line items example):</h3>
      <ul style={{ textAlign: 'left' }}>
        <LineItems lineItems={settings.line_items} />
      </ul>
      <h3>Results (LTI Advantage line item results example):</h3>
      <ul style={{ textAlign: 'left' }}>
        <Results lineItemResults={settings.line_item_results} />
      </ul>
    </div>
  );
}

function Content({ settings, courses }) {
  const canvasUrl = settings.canvas_url;
  if (settings.lti_message_type === 'ContentItemSelectionRequest') {
    return <Selector />;
  }

  if (settings.deep_link_settings) {
    return (
      <DeepLink
        deepLinkSettings={settings.deep_link_settings}
      />
    );
  }

  return (
    <div>
      <img src={img} alt="Atomic Jolt Logo" />
      <hr />
      <h2>Courses:</h2>
      <ul>
        <CourseList courses={courses} canvasUrl={canvasUrl} />
      </ul>
    </div>
  );
}

Content.propTypes = {
  settings: PropTypes.shape({
    canvas_auth_required: PropTypes.bool,
    lti_message_type: PropTypes.string,
    canvas_url: PropTypes.string,
  }).isRequired,
  courses: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
  })),
};

export default function Home() {
  const settings = useSettings();
  const canvasReAuthorizationRequired = useSelector(
    (state) => state.canvasErrors.canvasReAuthorizationRequired
  );

  const content = displayCanvasAuth(settings, canvasReAuthorizationRequired) || (
    <Content settings={settings} />
  );

  return (
    <div>
      {content}
      <Examples settings={settings} />
    </div>
  );
}
