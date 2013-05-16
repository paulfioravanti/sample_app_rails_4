shared_context "locale language labels" do |locale|
  def locale_labels
    scope = 'layouts.locale_selector'
    [
      { label: t(:en, scope: scope), locale: 'en' },
      { label: t(:it, scope: scope), locale: 'it' },
      { label: t(:ja, scope: scope), locale: 'ja' }
    ]
  end
end