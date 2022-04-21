import React from 'react';
import TestRenderer from 'react-test-renderer';
import CourseInstalls from './course_installs';

describe('lti installs course install', () => {
  let result;
  let props;
  const courseId = 123;
  let instance;

  beforeEach(() => {
    props = {
      applicationInstance: {
        name: 'application_name',
        lti_key: 'lti_key',
        lti_secret: 'lti_secret',
        lti_config_xml: 'lti_config_xml',
      },
      canvasRequest: () => {},
      onlyShowInstalledChanged: () => { changed = true; },
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
    result = TestRenderer.create(<CourseInstalls {...props} />);
    instance = result.root;
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders buttons', () => {
    const courseName = instance.findByType('span');
    expect(courseName.props().children).toBe('Course Name');
  });

  // Remove the checkbox so removing the test for now
  // it('handles the onChange for input', () => {
  //   expect(changed).toBeFalsy();
  //   const input = instance.findByType('input');
  //   input.simulate('change');
  //   expect(changed).toBeTruthy();
  // });
});
