module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Status < Metacrunch::Transformer::Step

          NEW_STATE    = "A".freeze
          DELETE_STATE = "D".freeze

          def perform
            target.add("control", "status", status)
          end

        private

          #
          # @return [String] "A" for new or updated records, "D" for deleted records.
          #
          def status
            status = NEW_STATE

            # gelöscht -> LDR Position 6 == 'd'
            status = DELETE_STATE if source.controlfield("LDR").at(5) == "d"

            # ausgesondert über Feld 078
            status = DELETE_STATE if source.datafields("078", ind1: "r").subfields("a").values.any?{ |s| s == "aus" }

            # Standort Detmold unterdrücken
            detmold_locations = source.datafields("LOC").subfields("n").values
            status = DELETE_STATE if detmold_locations.present? && detmold_locations.all?{ |l| l == "50" }

            # Interimsaufnahmen unterdrücken
            temp_records = source.datafields("537", ind1: "-", ind2: "1").subfields("a").values
            status = DELETE_STATE if temp_records.any?{ |v| v.downcase.include? "interimsaufnahme" }

            status
          end

        end
      end
    end
  end
end
