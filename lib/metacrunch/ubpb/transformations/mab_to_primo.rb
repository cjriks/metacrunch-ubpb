require "active_support"
require "active_support/core_ext"
require "metacrunch/mab2/document"
require "metacrunch/transformator/transformation"
require_relative "../transformations"

class Metacrunch::UBPB::Transformations::MabToPrimo < Metacrunch::Transformator::Transformation
  require_directory "#{File.dirname(__FILE__)}/mab_to_primo"

  # @param [String] source repesenting a MAB document in Aleph MAB XML format
  # @param [Hash] options
  # @option options [Hash] :target
  #
  # @return [Hash] transformation result
  def call(source, options = {})
    source = Metacrunch::Mab2::Document.from_aleph_mab_xml(source)
    options[:target] ||= {}

    super(source, options)
  end

  sequence [
    AddId,
    AddStatus,
    AddHtNumber,
    AddCreationDate,
    AddMaterialtyp,
    AddInhaltstyp,
    AddVolumeCount,
    AddTitle,
    AddTitleDisplay,
    AddTitleSort,
    AddShortTitleDisplay,
    AddTitleSearch,
    AddPersonCreatorDisplay,
    AddCorporateBodyCreatorDisplay,
    AddAuthorStatement,
    AddPersonContributorDisplay,
    AddCorporateBodyContributorDisplay,
    AddCreatorContributorDisplay,
    AddCreatorContributorFacet,
    AddCreatorContributorSearch,
    AddEdition,
    AddPublisher,
    AddCreationdate,
    AddCreationdateSearch,
    AddFormat,
    AddIsPartOf,
    AddIsbn,
    AddIssn,
    AddZdbId,
    AddSubject,
    AddSubjectSearch,
    AddDDC,
    AddAbstract,
    AddLanguage,
    AddRelation,
    AddSuperorderDisplay,
    AddSuperorder,
    AddIsSuperorder,
    AddIsSuborder,
    AddErscheinungsform,
    AddDescription,
    AddDeliveryCategory,
    AddVolumeCountSort,
    AddVolumeCountSort2,
    AddNotation,
    AddNotationSort,
    AddToc,
    AddSignature,
    AddSignatureSearch,
    AddResourceLink,
    AddLinkToToc,
    AddSelectionCode,
    AddLdsX,
    AddRedactionalRemark,
    AddIsSecondaryForm,
    AddSecondaryFormPreliminaryPhrase,
    AddSecondaryFormPublisher,
    AddSecondaryFormCreationdate,
    AddSecondaryFormIsbn,
    AddSecondaryFormPhysicalDescription,
    AddSecondaryFormSuperorder,
    AddLocalComment,
    AddAdditionalData
  ]
end