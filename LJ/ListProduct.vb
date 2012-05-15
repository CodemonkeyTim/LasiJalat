Public Class ListProduct
    Dim _id As Integer
    Dim _name As String
    Dim _category_name As String
    Dim _price As Decimal
    Dim _count As Integer
    Dim _total As Decimal
    Dim _image_url As String
    Dim _description As String

    Sub New(ByVal id As Integer, ByVal count As Integer, ByVal category_name As String, ByVal name As String, ByVal price As Decimal, ByVal image_url As String, ByVal description As String)
        _id = id
        _name = name
        _category_name = category_name
        _price = price
        _count = count
        _total = count * price
        _image_url = image_url
        _description = description
    End Sub

    Public Property Name As String
        Get
            Return _name
        End Get
        Set(ByVal value As String)
            _name = value
        End Set
    End Property

    Public Property Price As Decimal
        Get
            Return _price
        End Get
        Set(ByVal value As Decimal)
            _price = value
            _total = _count * _price
        End Set
    End Property

    Public ReadOnly Property id
        Get
            Return _id
        End Get
    End Property

    Public Property category As String
        Get
            Return _category_name
        End Get
        Set(ByVal value As String)
            _category_name = value
        End Set
    End Property

    Public Property count As Integer
        Get
            Return _count
        End Get
        Set(ByVal value As Integer)
            _count = value
            _total = _count * _price
        End Set
    End Property

    Public ReadOnly Property total As Decimal
        Get
            Return _total
        End Get
    End Property

    Public Property image_url As String
        Get
            Return _image_url
        End Get
        Set(ByVal value As String)
            _image_url = value
        End Set
    End Property

    Public Property description As String
        Get
            Return _description
        End Get
        Set(ByVal value As String)
            _description = value
        End Set
    End Property


End Class
