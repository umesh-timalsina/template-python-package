from pytest import fixture

from template_python_package import TemplateMain


class TestTemplateMain():
    @fixture(scope='module')
    def template_main(self):
        return TemplateMain(
            prop1='fancyString1',
            prop2='fancyString2'
        )

    def test_dict(self, template_main):
        assert 'prop1' in template_main.dict()
        assert 'prop2' in template_main.dict()
        assert list(template_main.dict().values()) == \
               ['fancyString1', 'fancyString2']

    def test_set(self, template_main):
        assert 'fancyString1' in template_main.set()
        assert 'fancyString2' in template_main.set()

    def test_tuple(self, template_main):
        assert 'fancyString1' in template_main.tuple()
        assert 'fancyString2' in template_main.tuple()

    def test_list(self, template_main):
        assert 'fancyString1' in template_main.list()
        assert 'fancyString2' in template_main.list()
