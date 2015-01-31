module ResumesHelper

  # render Html page using Liquid
  def liquidize(content, args)
    liquid = Liquid::Template.parse(content)
    return liquid.render(args)
  end
end
