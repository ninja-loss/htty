require 'htty/cli/commands/headers_set'
require 'htty/cli/commands/header_set'
require 'htty/cli/commands/headers_request'
require 'htty/cli/commands/headers_unset'
require 'htty/cli/commands/headers_unset_all'

RSpec.describe HTTY::CLI::Commands::HeadersSet do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([HTTY::CLI::Commands::HeaderSet])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Building Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('headers-s[et]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('NAME VALUE')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Sets a header of the request')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Sets a header used for the request. Does not communicate with the host.

Headers must have unique names. When you set a header that already exists, its value will be changed.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::HeadersRequest,
                                             HTTY::CLI::Commands::HeadersUnset,
                                             HTTY::CLI::Commands::HeadersUnsetAll])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-set foo bar', session: :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(%w(foo bar))
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers-s baz qux', session: :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(%w(baz qux))
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x quux corge', session: :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
