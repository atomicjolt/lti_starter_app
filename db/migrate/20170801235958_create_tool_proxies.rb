# Derived from https://github.com/instructure/lti_originality_report_example
# MIT License

# Copyright (c) 2017 Instructure, Inc.
# Copyright (c) 2017 Atomic Jolt

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
class CreateToolProxies < ActiveRecord::Migration[5.0]
  def change

    create_table :tool_proxies, force: :cascade do |t|
      t.integer :application_instance_id
      t.string :guid,                   null: false
      t.string :shared_secret,          null: false
      t.string :tcp_url,                null: false
      t.string :base_url,               null: false
      t.string :authorization_url
      t.string :report_service_url
      t.string :submission_service_url
      t.timestamps
    end
    add_index :tool_proxies, :guid
    add_index :tool_proxies, :application_instance_id

  end
end
