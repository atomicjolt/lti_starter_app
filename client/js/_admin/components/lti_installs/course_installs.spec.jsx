import React              from 'react';
import TestUtils          from 'react-addons-test-utils';
import { Provider }       from 'react-redux';
import Helper             from '../../../../specs_support/helper';
import CourseInstalls     from './course_installs';

describe('lti installs course install', () => {

  let result;
  let courseId = 123;

  const props = {
    applicationInstance: {
      name: 'application_name',
      lti_key: 'lti_key',
      lti_secret: 'lti_secret',
      lti_config_xml: 'lti_config_xml',
    },
    canvasRequest: () => {},
    loadingCourses: {
      courseName: 'name',
      courseId: 'id',
    },
    courses: [],
    installedTool: {
      id: 12
    },
    courseName: 'courseName',
    courseId,
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <CourseInstalls {...props} />
      </Provider>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('renders buttons', () => {
    const courseName = TestUtils.findRenderedDOMComponentWithTag(result, 'span');
    expect(courseName.textContent).toBe('Course Name');
  });

});
