import courses from './courses';

describe('courses reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = courses(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('list active courses in account', () => {
    it('list active courses', () => {
      const state = undefined;
      const courseId = 1;
      const externalToolsId = 2;
      const externalTools = { id: externalToolsId };
      const result = courses(state, {
        type: 'LIST_ACTIVE_COURSES_IN_ACCOUNT_DONE',
        payload: [{ external_tools: externalTools, id: courseId }]
      });
      expect(result[courseId]).toBeDefined();
      expect(result[courseId].external_tools.id).toBe(externalToolsId);
    });
  });

  describe('list external tools in courses', () => {
    it('list external tools in courses', () => {
      const courseId = 1;
      const externalToolsId = 2;
      const payload = [{ id: 1 }];
      const state = { 1: { external_tools: { id: externalToolsId } } };
      const result = courses(state, {
        type: 'LIST_EXTERNAL_TOOLS_COURSES_DONE',
        payload,
        original: {
          params: {
            course_id: courseId
          }
        }
      });
      expect(result[courseId]).toBeDefined();
      expect(result[courseId].external_tools.id).toBe(externalToolsId);
    });
  });

  describe('create external tools in courses', () => {
    it('create external tools in courses', () => {
      const courseId = 1;
      const payloadId = 1;
      const payload = { id: payloadId };
      const state = { 1: { external_tools: { } } };
      const result = courses(state, {
        type: 'CREATE_EXTERNAL_TOOL_COURSES_DONE',
        payload,
        original: {
          params: {
            course_id: courseId
          }
        }
      });
      expect(result[courseId]).toBeDefined();
      expect(result[courseId].external_tools[payloadId].id).toBe(payloadId);
    });
  });

  describe('create external tools in courses', () => {
    it('create external tools in courses', () => {
      const courseId = 1;
      const payloadId = 1;
      const payload = { id: payloadId };
      const state = { 1: { external_tools: { } } };
      const result = courses(state, {
        type: 'DELETE_EXTERNAL_TOOL_COURSES_DONE',
        payload,
        original: {
          params: {
            course_id: courseId
          }
        }
      });
      expect(result[courseId]).toBeDefined();
      expect(result[courseId].external_tools[payloadId]).not.toBeDefined();
    });
  });
});
