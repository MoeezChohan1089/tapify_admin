/// Mutation to remove a gift card from a checkout
const String checkoutGiftCardRemoveMutation = r'''
mutation checkoutGiftCard($appliedGiftCardId : ID!, $checkoutId: ID!) {
  checkoutGiftCardRemoveV2(appliedGiftCardId: $appliedGiftCardId, checkoutId: $checkoutId) {
    checkoutUserErrors {
      code
      field
      message
    }
    checkout {
      id
      email
      ready
      appliedGiftCards {
        amountUsedV2 {
          amount
          currencyCode
        }
        balanceV2 {
          amount
          currencyCode
        }
        id
        lastCharacters
      }
      requiresShipping
      shippingLine {
        handle
        priceV2 {
          amount
          currencyCode
        }
        title
      }
      shippingAddress {
        address1
        address2
        city
        company
        country
        countryCodeV2
        firstName
        formattedArea
        id
        lastName
        latitude
        longitude
        name
        phone
        province
        provinceCode
        zip
      }
      completedAt
      createdAt
      currencyCode
      lineItems(first: 10) {
        edges {
          node {
            id
            quantity
            title
            customAttributes {
                key
                value
            }
             discountAllocations {
              allocatedAmount {
                amount
                currencyCode
              }
            }
            variant {
              id
              priceV2 {
                amount
                currencyCode
              }
              title
              quantityAvailable
              image {
                altText
                originalSrc
                id
              }
              compareAtPriceV2 {
                amount
                currencyCode
              }
              weight
              weightUnit
              availableForSale
              sku
              requiresShipping
              product {
                options(first: 50) {
                    id
                    name
                    values
                    } 
                variants(first: 250) {
                  edges {
                    node {
                      id
                      title
                      image {
                        altText
                        id
                        originalSrc
                      }
                      priceV2 {
                        amount
                        currencyCode
                      }
                      compareAtPriceV2 {
                        amount
                        currencyCode
                      }
                      weight
                      weightUnit
                      availableForSale
                      sku
                      requiresShipping
                      quantityAvailable
                      selectedOptions {
                        name
                        value
                      }
                    }
                  }
                  pageInfo {
                    hasNextPage
                  }
                }
                availableForSale
                collections(first: 5) {
                  edges {
                    node {
                      description
                      descriptionHtml
                      id
                      handle
                      updatedAt
                      title
                    }
                  }
                }
                createdAt
                description
                descriptionHtml
                handle
                id
                onlineStoreUrl
                productType
                publishedAt
                tags
                title
                updatedAt
                vendor
                images(first: 5) {
                  edges {
                    node {
                      altText
                      id
                      originalSrc
                    }
                  }
                }
              }
            }
          }
        }
      }
      note
      webUrl
      updatedAt
      totalTaxV2 {
        amount
        currencyCode
      }
      totalPriceV2 {
        amount
        currencyCode
      }
      taxesIncluded
      taxExempt
      subtotalPriceV2 {
        amount
        currencyCode
      }
      orderStatusUrl
      order {
        id
      }
    }
  }
}
''';