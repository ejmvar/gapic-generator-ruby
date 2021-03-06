# frozen_string_literal: true

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "json"
require "pathname"

require "googleauth"
require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/cloud/vision/v1/product_search_service_pb"

module Google
  module Cloud
    module Vision
      module V1
        module ProductSearch
          class Credentials < Google::Auth::Credentials
            SCOPE = [
              "https://www.googleapis.com/auth/cloud-platform"
            ].freeze
            PATH_ENV_VARS = %w[PRODUCTSEARCH_CREDENTIALS
                               PRODUCTSEARCH_KEYFILE
                               GOOGLE_CLOUD_CREDENTIALS
                               GOOGLE_CLOUD_KEYFILE
                               GCLOUD_KEYFILE].freeze
            JSON_ENV_VARS = %w[PRODUCTSEARCH_CREDENTIALS_JSON
                               PRODUCTSEARCH_KEYFILE_JSON
                               GOOGLE_CLOUD_CREDENTIALS_JSON
                               GOOGLE_CLOUD_KEYFILE_JSON
                               GCLOUD_KEYFILE_JSON].freeze
            DEFAULT_PATHS = ["~/.config/google_cloud/application_default_credentials.json"].freeze
          end

          # Service that implements Google Cloud Speech API.
          class Client
            # @private
            attr_reader :stub

            # The default address of the service.
            SERVICE_ADDRESS = "vision.googleapis.com"

            # The default port of the service.
            DEFAULT_SERVICE_PORT = 443

            # rubocop:disable Style/MutableConstant

            # The default set of gRPC interceptors.
            GRPC_INTERCEPTORS = []

            # rubocop:enable Style/MutableConstant

            DEFAULT_TIMEOUT = 30

            # The scopes needed to make gRPC calls to all of the methods defined
            # in this service.
            ALL_SCOPES = ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/cloud-vision"].freeze

            # @private
            class OperationsClient < Google::Longrunning::OperationsClient
              SERVICE_ADDRESS = Client::SERVICE_ADDRESS
              GRPC_INTERCEPTORS = Client::GRPC_INTERCEPTORS.dup
            end

            ##
            # @param credentials [Google::Auth::Credentials, String, Hash,
            #   GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
            #   Provides the means for authenticating requests made by the client. This
            #   parameter can be many types.
            #   A `Google::Auth::Credentials` uses a the properties of its represented
            #   keyfile for authenticating requests made by this client.
            #   A `String` will be treated as the path to the keyfile to be used for the
            #   construction of credentials for this client.
            #   A `Hash` will be treated as the contents of a keyfile to be used for the
            #   construction of credentials for this client.
            #   A `GRPC::Core::Channel` will be used to make calls through.
            #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The
            #   channel credentials should already be composed with a
            #   `GRPC::Core::CallCredentials` object.
            #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc
            #   transforms the metadata for requests, generally, to give OAuth credentials.
            # @param scopes [Array<String>]
            #   The OAuth scopes for this service. This parameter is ignored if an
            #   updater_proc is supplied.
            # @param client_config [Hash]
            #   A Hash for call options for each method. See Google::Gax#construct_settings
            #   for the structure of this data. Falls back to the default config if not
            #   specified or the specified config is missing data points.
            # @param timeout [Numeric]
            #   The default timeout, in seconds, for calls made through this client.
            # @param metadata [Hash]
            #   Default metadata to be sent with each request. This can be overridden on a
            #   per call basis.
            # @param exception_transformer [Proc]
            #   An optional proc that intercepts any exceptions raised during an API call to
            #   inject custom error handling.
            #
            def initialize \
                credentials: nil,
                scopes: ALL_SCOPES,
                client_config: {},
                timeout: DEFAULT_TIMEOUT,
                metadata: nil,
                exception_transformer: nil,
                lib_name: nil,
                lib_version: ""
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "google/gax/grpc"
              require "google/cloud/vision/v1/product_search_service_services_pb"

              credentials ||= Credentials.default

              @operations_client = OperationsClient.new(
                credentials: credentials,
                scopes: scopes,
                client_config: client_config,
                timeout: timeout,
                lib_name: lib_name,
                lib_version: lib_version
              )

              @stub = create_stub credentials, scopes

              defaults = default_settings client_config, timeout, metadata, lib_name, lib_version

              @create_product_set = Google::Gax.create_api_call(
                @stub.method(:create_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @list_product_sets = Google::Gax.create_api_call(
                @stub.method(:list_product_sets),
                defaults,
                exception_transformer: exception_transformer
              )

              @get_product_set = Google::Gax.create_api_call(
                @stub.method(:get_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @update_product_set = Google::Gax.create_api_call(
                @stub.method(:update_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @delete_product_set = Google::Gax.create_api_call(
                @stub.method(:delete_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @create_product = Google::Gax.create_api_call(
                @stub.method(:create_product),
                defaults,
                exception_transformer: exception_transformer
              )

              @list_products = Google::Gax.create_api_call(
                @stub.method(:list_products),
                defaults,
                exception_transformer: exception_transformer
              )

              @get_product = Google::Gax.create_api_call(
                @stub.method(:get_product),
                defaults,
                exception_transformer: exception_transformer
              )

              @update_product = Google::Gax.create_api_call(
                @stub.method(:update_product),
                defaults,
                exception_transformer: exception_transformer
              )

              @delete_product = Google::Gax.create_api_call(
                @stub.method(:delete_product),
                defaults,
                exception_transformer: exception_transformer
              )

              @create_reference_image = Google::Gax.create_api_call(
                @stub.method(:create_reference_image),
                defaults,
                exception_transformer: exception_transformer
              )

              @delete_reference_image = Google::Gax.create_api_call(
                @stub.method(:delete_reference_image),
                defaults,
                exception_transformer: exception_transformer
              )

              @list_reference_images = Google::Gax.create_api_call(
                @stub.method(:list_reference_images),
                defaults,
                exception_transformer: exception_transformer
              )

              @get_reference_image = Google::Gax.create_api_call(
                @stub.method(:get_reference_image),
                defaults,
                exception_transformer: exception_transformer
              )

              @add_product_to_product_set = Google::Gax.create_api_call(
                @stub.method(:add_product_to_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @remove_product_from_product_set = Google::Gax.create_api_call(
                @stub.method(:remove_product_from_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @list_products_in_product_set = Google::Gax.create_api_call(
                @stub.method(:list_products_in_product_set),
                defaults,
                exception_transformer: exception_transformer
              )

              @import_product_sets = Google::Gax.create_api_call(
                @stub.method(:import_product_sets),
                defaults,
                exception_transformer: exception_transformer
              )
            end

            # Service calls

            ##
            # Creates and returns a new ProductSet resource.
            #
            #  Possible errors:
            #
            #  * Returns INVALID_ARGUMENT if display_name is missing, or is longer than
            #    4096 characters.
            #
            # @param parent [String]
            #   The project in which the ProductSet should be created.
            #
            #    Format is `projects/PROJECT_ID/locations/LOC_ID`.
            # @param product_set [Google::Cloud::Vision::V1::ProductSet | Hash]
            #   The ProductSet to create.
            # @param product_set_id [String]
            #   A user-supplied resource id for this ProductSet. If set, the server will
            #    attempt to use this value as the resource id. If it is already in use, an
            #    error is returned with code ALREADY_EXISTS. Must be at most 128 characters
            #    long. It cannot contain the character `/`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def create_product_set \
                parent,
                product_set,
                product_set_id,
                options: nil,
                &block

              request = {
                parent: parent,
                product_set: product_set,
                product_set_id: product_set_id
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::CreateProductSetRequest
              @create_product_set.call(request, options, &block)
            end

            ##
            # Lists ProductSets in an unspecified order.
            #
            #  Possible errors:
            #
            #  * Returns INVALID_ARGUMENT if page_size is greater than 100, or less
            #    than 1.
            #
            # @param parent [String]
            #   The project from which ProductSets should be listed.
            #
            #    Format is `projects/PROJECT_ID/locations/LOC_ID`.
            # @param page_size [Integer]
            #   The maximum number of items to return. Default 10, maximum 100.
            # @param page_token [String]
            #   The next_page_token returned from a previous List request, if any.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ListProductSetsResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ListProductSetsResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_product_sets \
                parent,
                page_size,
                page_token,
                options: nil,
                &block

              request = {
                parent: parent,
                page_size: page_size,
                page_token: page_token
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListProductSetsRequest
              @list_product_sets.call(request, options, &block)
            end

            ##
            # Gets information associated with a ProductSet.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the ProductSet does not exist.
            #
            # @param name [String]
            #   Resource name of the ProductSet to get.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOG_ID/productSets/PRODUCT_SET_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_product_set \
                name,
                options: nil,
                &block

              request = {
                name: name
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::GetProductSetRequest
              @get_product_set.call(request, options, &block)
            end

            ##
            # Makes changes to a ProductSet resource.
            #  Only display_name can be updated currently.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the ProductSet does not exist.
            #  * Returns INVALID_ARGUMENT if display_name is present in update_mask but
            #    missing from the request or longer than 4096 characters.
            #
            # @param product_set [Google::Cloud::Vision::V1::ProductSet | Hash]
            #   The ProductSet resource which replaces the one on the server.
            # @param update_mask [Google::Protobuf::FieldMask | Hash]
            #   The [FieldMask][google.protobuf.FieldMask] that specifies which fields to
            #    update.
            #    If update_mask isn't specified, all mutable fields are to be updated.
            #    Valid mask path is `display_name`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ProductSet]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ProductSet]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def update_product_set \
                product_set,
                update_mask,
                options: nil,
                &block

              request = {
                product_set: product_set,
                update_mask: update_mask
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::UpdateProductSetRequest
              @update_product_set.call(request, options, &block)
            end

            ##
            # Permanently deletes a ProductSet. Products and ReferenceImages in the
            #  ProductSet are not deleted.
            #
            #  The actual image files are not deleted from Google Cloud Storage.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the ProductSet does not exist.
            #
            # @param name [String]
            #   Resource name of the ProductSet to delete.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_product_set \
                name,
                options: nil,
                &block

              request = {
                name: name
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::DeleteProductSetRequest
              @delete_product_set.call(request, options, &block)
            end

            ##
            # Creates and returns a new product resource.
            #
            #  Possible errors:
            #
            #  * Returns INVALID_ARGUMENT if display_name is missing or longer than 4096
            #    characters.
            #  * Returns INVALID_ARGUMENT if description is longer than 4096 characters.
            #  * Returns INVALID_ARGUMENT if product_category is missing or invalid.
            #
            # @param parent [String]
            #   The project in which the Product should be created.
            #
            #    Format is
            #    `projects/PROJECT_ID/locations/LOC_ID`.
            # @param product [Google::Cloud::Vision::V1::Product | Hash]
            #   The product to create.
            # @param product_id [String]
            #   A user-supplied resource id for this Product. If set, the server will
            #    attempt to use this value as the resource id. If it is already in use, an
            #    error is returned with code ALREADY_EXISTS. Must be at most 128 characters
            #    long. It cannot contain the character `/`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def create_product \
                parent,
                product,
                product_id,
                options: nil,
                &block

              request = {
                parent: parent,
                product: product,
                product_id: product_id
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::CreateProductRequest
              @create_product.call(request, options, &block)
            end

            ##
            # Lists products in an unspecified order.
            #
            #  Possible errors:
            #
            #  * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #
            # @param parent [String]
            #   The project OR ProductSet from which Products should be listed.
            #
            #    Format:
            #    `projects/PROJECT_ID/locations/LOC_ID`
            # @param page_size [Integer]
            #   The maximum number of items to return. Default 10, maximum 100.
            # @param page_token [String]
            #   The next_page_token returned from a previous List request, if any.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ListProductsResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ListProductsResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_products \
                parent,
                page_size,
                page_token,
                options: nil,
                &block

              request = {
                parent: parent,
                page_size: page_size,
                page_token: page_token
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListProductsRequest
              @list_products.call(request, options, &block)
            end

            ##
            # Gets information associated with a Product.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the Product does not exist.
            #
            # @param name [String]
            #   Resource name of the Product to get.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_product \
                name,
                options: nil,
                &block

              request = {
                name: name
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::GetProductRequest
              @get_product.call(request, options, &block)
            end

            ##
            # Makes changes to a Product resource.
            #  Only the `display_name`, `description`, and `labels` fields can be updated
            #  right now.
            #
            #  If labels are updated, the change will not be reflected in queries until
            #  the next index time.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the Product does not exist.
            #  * Returns INVALID_ARGUMENT if display_name is present in update_mask but is
            #    missing from the request or longer than 4096 characters.
            #  * Returns INVALID_ARGUMENT if description is present in update_mask but is
            #    longer than 4096 characters.
            #  * Returns INVALID_ARGUMENT if product_category is present in update_mask.
            #
            # @param product [Google::Cloud::Vision::V1::Product | Hash]
            #   The Product resource which replaces the one on the server.
            #    product.name is immutable.
            # @param update_mask [Google::Protobuf::FieldMask | Hash]
            #   The [FieldMask][google.protobuf.FieldMask] that specifies which fields
            #    to update.
            #    If update_mask isn't specified, all mutable fields are to be updated.
            #    Valid mask paths include `product_labels`, `display_name`, and
            #    `description`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::Product]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::Product]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def update_product \
                product,
                update_mask,
                options: nil,
                &block

              request = {
                product: product,
                update_mask: update_mask
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::UpdateProductRequest
              @update_product.call(request, options, &block)
            end

            ##
            # Permanently deletes a product and its reference images.
            #
            #  Metadata of the product and all its images will be deleted right away, but
            #  search queries against ProductSets containing the product may still work
            #  until all related caches are refreshed.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the product does not exist.
            #
            # @param name [String]
            #   Resource name of product to delete.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_product \
                name,
                options: nil,
                &block

              request = {
                name: name
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::DeleteProductRequest
              @delete_product.call(request, options, &block)
            end

            ##
            # Creates and returns a new ReferenceImage resource.
            #
            #  The `bounding_poly` field is optional. If `bounding_poly` is not specified,
            #  the system will try to detect regions of interest in the image that are
            #  compatible with the product_category on the parent product. If it is
            #  specified, detection is ALWAYS skipped. The system converts polygons into
            #  non-rotated rectangles.
            #
            #  Note that the pipeline will resize the image if the image resolution is too
            #  large to process (above 50MP).
            #
            #  Possible errors:
            #
            #  * Returns INVALID_ARGUMENT if the image_uri is missing or longer than 4096
            #    characters.
            #  * Returns INVALID_ARGUMENT if the product does not exist.
            #  * Returns INVALID_ARGUMENT if bounding_poly is not provided, and nothing
            #    compatible with the parent product's product_category is detected.
            #  * Returns INVALID_ARGUMENT if bounding_poly contains more than 10 polygons.
            #
            # @param parent [String]
            #   Resource name of the product in which to create the reference image.
            #
            #    Format is
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
            # @param reference_image [Google::Cloud::Vision::V1::ReferenceImage | Hash]
            #   The reference image to create.
            #    If an image ID is specified, it is ignored.
            # @param reference_image_id [String]
            #   A user-supplied resource id for the ReferenceImage to be added. If set,
            #    the server will attempt to use this value as the resource id. If it is
            #    already in use, an error is returned with code ALREADY_EXISTS. Must be at
            #    most 128 characters long. It cannot contain the character `/`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ReferenceImage]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ReferenceImage]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def create_reference_image \
                parent,
                reference_image,
                reference_image_id,
                options: nil,
                &block

              request = {
                parent: parent,
                reference_image: reference_image,
                reference_image_id: reference_image_id
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::CreateReferenceImageRequest
              @create_reference_image.call(request, options, &block)
            end

            ##
            # Permanently deletes a reference image.
            #
            #  The image metadata will be deleted right away, but search queries
            #  against ProductSets containing the image may still work until all related
            #  caches are refreshed.
            #
            #  The actual image files are not deleted from Google Cloud Storage.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the reference image does not exist.
            #
            # @param name [String]
            #   The resource name of the reference image to delete.
            #
            #    Format is:
            #
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def delete_reference_image \
                name,
                options: nil,
                &block

              request = {
                name: name
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::DeleteReferenceImageRequest
              @delete_reference_image.call(request, options, &block)
            end

            ##
            # Lists reference images.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the parent product does not exist.
            #  * Returns INVALID_ARGUMENT if the page_size is greater than 100, or less
            #    than 1.
            #
            # @param parent [String]
            #   Resource name of the product containing the reference images.
            #
            #    Format is
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`.
            # @param page_size [Integer]
            #   The maximum number of items to return. Default 10, maximum 100.
            # @param page_token [String]
            #   A token identifying a page of results to be returned. This is the value
            #    of `nextPageToken` returned in a previous reference image list request.
            #
            #    Defaults to the first page if not specified.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ListReferenceImagesResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ListReferenceImagesResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_reference_images \
                parent,
                page_size,
                page_token,
                options: nil,
                &block

              request = {
                parent: parent,
                page_size: page_size,
                page_token: page_token
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListReferenceImagesRequest
              @list_reference_images.call(request, options, &block)
            end

            ##
            # Gets information associated with a ReferenceImage.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the specified image does not exist.
            #
            # @param name [String]
            #   The resource name of the ReferenceImage to get.
            #
            #    Format is:
            #
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID/referenceImages/IMAGE_ID`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ReferenceImage]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ReferenceImage]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def get_reference_image \
                name,
                options: nil,
                &block

              request = {
                name: name
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::GetReferenceImageRequest
              @get_reference_image.call(request, options, &block)
            end

            ##
            # Adds a Product to the specified ProductSet. If the Product is already
            #  present, no change is made.
            #
            #  One Product can be added to at most 100 ProductSets.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND if the Product or the ProductSet doesn't exist.
            #
            # @param name [String]
            #   The resource name for the ProductSet to modify.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            # @param product [String]
            #   The resource name for the Product to be added to this ProductSet.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def add_product_to_product_set \
                name,
                product,
                options: nil,
                &block

              request = {
                name: name,
                product: product
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::AddProductToProductSetRequest
              @add_product_to_product_set.call(request, options, &block)
            end

            ##
            # Removes a Product from the specified ProductSet.
            #
            #  Possible errors:
            #
            #  * Returns NOT_FOUND If the Product is not found under the ProductSet.
            #
            # @param name [String]
            #   The resource name for the ProductSet to modify.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            # @param product [String]
            #   The resource name for the Product to be removed from this ProductSet.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/products/PRODUCT_ID`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Protobuf::Empty]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Protobuf::Empty]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def remove_product_from_product_set \
                name,
                product,
                options: nil,
                &block

              request = {
                name: name,
                product: product
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest
              @remove_product_from_product_set.call(request, options, &block)
            end

            ##
            # Lists the Products in a ProductSet, in an unspecified order. If the
            #  ProductSet does not exist, the products field of the response will be
            #  empty.
            #
            #  Possible errors:
            #
            #  * Returns INVALID_ARGUMENT if page_size is greater than 100 or less than 1.
            #
            # @param name [String]
            #   The ProductSet resource for which to retrieve Products.
            #
            #    Format is:
            #    `projects/PROJECT_ID/locations/LOC_ID/productSets/PRODUCT_SET_ID`
            # @param page_size [Integer]
            #   The maximum number of items to return. Default 10, maximum 100.
            # @param page_token [String]
            #   The next_page_token returned from a previous List request, if any.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Vision::V1::ListProductsInProductSetResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            #
            # @return [Google::Cloud::Vision::V1::ListProductsInProductSetResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def list_products_in_product_set \
                name,
                page_size,
                page_token,
                options: nil,
                &block

              request = {
                name: name,
                page_size: page_size,
                page_token: page_token
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ListProductsInProductSetRequest
              @list_products_in_product_set.call(request, options, &block)
            end

            ##
            # Asynchronous API that imports a list of reference images to specified
            #  product sets based on a list of image information.
            #
            #  The [google.longrunning.Operation][google.longrunning.Operation] API can be
            #  used to keep track of the progress and results of the request.
            #  `Operation.metadata` contains `BatchOperationMetadata`. (progress)
            #  `Operation.response` contains `ImportProductSetsResponse`. (results)
            #
            #  The input source of this method is a csv file on Google Cloud Storage.
            #  For the format of the csv file please see
            #  [ImportProductSetsGcsSource.csv_file_uri][google.cloud.vision.v1.ImportProductSetsGcsSource.csv_file_uri].
            #
            # @param parent [String]
            #   The project in which the ProductSets should be imported.
            #
            #    Format is `projects/PROJECT_ID/locations/LOC_ID`.
            # @param input_config [Google::Cloud::Vision::V1::ImportProductSetsInputConfig | Hash]
            #   The input content for the list of requests.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout, retries, etc.
            #
            # @yield [operation] Register a callback to be run when an operation is done.
            # @yieldparam operation [Google::Gax::Operation]
            #
            # @return [Google::Gax::Operation]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   TODO
            #
            def import_product_sets \
                parent,
                input_config,
                options: nil

              request = {
                parent: parent,
                input_config: input_config
              }.delete_if { |_, v| v.nil? }
              request = Google::Gax.to_proto request, Google::Cloud::Vision::V1::ImportProductSetsRequest
              operation = Google::Gax::Operation.new(
                @import_product_sets.call(request, options),
                @operations_client,
                call_options: options
              )
              operation.on_done { |operation| yield operation } if block_given?
              operation
            end

            protected

            def create_stub credentials, scopes
              if credentials.is_a?(String) || credentials.is_a?(Hash)
                updater_proc = Credentials.new(credentials).updater_proc
              elsif credentials.is_a? GRPC::Core::Channel
                channel = credentials
              elsif credentials.is_a? GRPC::Core::ChannelCredentials
                chan_creds = credentials
              elsif credentials.is_a? Proc
                updater_proc = credentials
              elsif credentials.is_a? Google::Auth::Credentials
                updater_proc = credentials.updater_proc
              end

              # Allow overriding the service path/port in subclasses.
              service_path = self.class::SERVICE_ADDRESS
              port = self.class::DEFAULT_SERVICE_PORT
              interceptors = self.class::GRPC_INTERCEPTORS
              stub_new = Google::Cloud::Vision::V1::ProductSearch::Stub.method :new
              Google::Gax::Grpc.create_stub(
                service_path,
                port,
                chan_creds: chan_creds,
                channel: channel,
                updater_proc: updater_proc,
                scopes: scopes,
                interceptors: interceptors,
                &stub_new
              )
            end

            def default_settings _client_config, _timeout, metadata, lib_name,
                                 lib_version
              package_gem = Gem.loaded_specs["google-cloud-vision"]
              package_version = package_gem ? package_gem.version.version : nil

              google_api_client = ["gl-ruby/#{RUBY_VERSION}"]
              google_api_client << "#{lib_name}/#{lib_version}" if lib_name
              google_api_client << "gapic/#{package_version}" if package_version
              google_api_client << "gax/#{Google::Gax::VERSION}"
              google_api_client << "grpc/#{GRPC::VERSION}"
              google_api_client.join " "

              headers = { "x-goog-api-client": google_api_client }
              headers.merge! metadata unless metadata.nil?

              Google::Gax.const_get(:CallSettings).new metadata: headers
            end
          end
        end
      end
    end
  end
end

# rubocop:disable Lint/HandleExceptions

# Once client is loaded, load helpers.rb if it exists.
begin
  require "google/cloud/vision/v1/helpers"
rescue LoadError
end

# rubocop:enable Lint/HandleExceptions
