# frozen_string_literal: true

# Copyright [yyyy] [name of copyright owner]
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require "test_helper"
require "google/gapic/generators/my_plugin_generator"

class MyPluginGeneratorTest < GeneratorTest
  def test_speech_generate
    generator = Google::Gapic::Generators::MyPluginGenerator.new api(:speech)
    generator.generate.each do |file|
      assert_equal expected_content("my_plugin/#{file.name}"), file.content
    end
  end
end
