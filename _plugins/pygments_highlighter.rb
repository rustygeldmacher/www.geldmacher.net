# Restore Pygments-based syntax highlighting for `{% highlight %}` blocks.
#
# Jekyll 4 removed built-in Pygments support: with `highlighter: pygments`
# it now falls back to Rouge, which emits different token markup. Since the
# `pygments.rb` gem is still available, we override `render_pygments` to
# reproduce Jekyll 3.8's exact output. Jekyll 4's render dispatch already
# routes to `render_pygments` when the configured highlighter is "pygments".
require "pygments"

module Jekyll
  module Tags
    class HighlightBlock < Liquid::Block
      def render_pygments(code, _context)
        highlighted_code = Pygments.highlight(
          code,
          :lexer   => @lang,
          :options => sanitized_opts(@highlight_options)
        )

        if highlighted_code.nil?
          raise ArgumentError, "Pygments.rb returned an unacceptable value " \
            "when attempting to highlight some code."
        end

        highlighted_code.sub('<div class="highlight"><pre>', "").sub("</pre></div>", "")
      end

      private

      def sanitized_opts(opts)
        Hash[[
          [:startinline, opts.fetch(:startinline, nil)],
          [:hl_lines,    opts.fetch(:hl_lines, nil)],
          [:linenos,     opts.fetch(:linenos, nil)],
          [:encoding,    opts.fetch(:encoding, "utf-8")],
          [:cssclass,    opts.fetch(:cssclass, nil)],
        ].reject { |f| f.last.nil? }]
      end
    end
  end
end
