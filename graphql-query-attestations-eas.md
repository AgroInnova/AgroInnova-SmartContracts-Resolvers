```graphql
query Query($where: AttestationWhereInput) {
  attestations(where: $where) {
    data
    revoked
    expirationTime
  }
}
```
```graphql
{
  "where": {
    "schemaId": {
      "equals": "0x14050ed8107691323eb632a934dfc33e1338e7950894a8edb1d3f6fbce0d79fe"
    },
    "AND": [
      {
        "AND": [
          {
            "recipient": {
              "equals": "0x1684C2a107C113c4CCB02dF651933978491dB385"
            },
            "decodedDataJson": {
              "contains": "ahfvi-daemh-hxw2t-l4szj-ejk4r-wzbtg-cj3x2-2n4hm-s4ptj-aau4r"
            }
          }
        ]
      }
    ],
  }
}
```
